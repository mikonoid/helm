def unitTest(ctx) {
   echo "build Helm chart for component ${ctx.component.name} version ${ctx.component.pkg.version}"

   sh ctx.helm.lint(".")
   sh ctx.helm.template(".")
}


def componentTest(ctx) {
    echo "Running ${ctx.testCategories} component tests for ${ctx.component.name}"

    // deploy chart
    ctx.k8s.withNamespace(name:ctx.component.name, random:true) {
        // Create docker repo secret
        sh ctx.kubectl.create("""secret docker-registry regcred
        --docker-server=${ctx.artifactory.docker.credentials.server}
        --docker-username=${ctx.artifactory.docker.credentials.username}
        --docker-password='${ctx.artifactory.docker.credentials.password}'""".stripIndent().trim().replace('\n', ' '))

        ctx.helm.withRelease(ctx.k8s.currentNamespace){

          def clusterPassword = 'cluster' + randomId()
          def gatewayPassword = 'gateway' + randomId()
          sh ctx.helm.install("""--set cluster.auth.user='nats_cluster' \
                    --set cluster.auth.password='${clusterPassword}' \
                    --set gateway.auth.user='nats_gateway' \
                    --set gateway.auth.password='${gatewayPassword}' \
                    --wait .""")
        }
   }

   def chartVersionStatus = sh (returnStatus: true, script: "git show -- Chart.yaml | grep -q '+version'")
   if (chartVersionStatus) {
      echo "Not uploading chart ${ctx.component.name} to artifactory"
   }
   else {
      echo "Uploading chart ${ctx.component.name} to artifactory"
      ctx.artifactory.helm.packageAndPush(ctx.helm, ctx.component, ctx.component.name)
   }
}


return [
    name: 'nats',
    version: [major: 3],
    type: 'chart',
    pkg: [type: 'helm/chart'],
    build: [method:this.&unitTest, env:'helm'],
    test: [
      component: this.&componentTest,
    ],
]
