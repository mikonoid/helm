{{/* vim: set filetype=mustache: */}}

{{/*
Expand the name of the chart.
*/}}
{{- define "nats.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "nats.fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "nats.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Return the proper Nats image name
*/}}
{{- define "nats.image" -}}
{{- $registryName := .Values.image.registry -}}
{{- $repositoryName := .Values.image.repository -}}
{{- $tag := .Values.image.tag | toString -}}
{{/*
Helm 2.11 supports the assignment of a value to a variable defined in a different scope,
but Helm 2.9 and 2.10 doesn't support it, so we need to implement this if-else logic.
Also, we can't use a single if because lazy evaluation is not an option
*/}}
{{- if .Values.global }}
    {{- if .Values.global.imageRegistry }}
        {{- printf "%s/%s:%s" .Values.global.imageRegistry $repositoryName $tag -}}
    {{- else -}}
        {{- printf "%s/%s:%s" $registryName $repositoryName $tag -}}
    {{- end -}}
{{- else -}}
    {{- printf "%s/%s:%s" $registryName $repositoryName $tag -}}
{{- end -}}
{{- end -}}

{{/*
Create a random alphanumeric password string.
We prepend a random letter to the string to avoid password validation errors
*/}}
{{- define "nats.randomPassword" -}}
{{- randAlpha 1 -}}{{- randAlphaNum 9 -}}
{{- end -}}

{{/*
Return the appropriate apiVersion for networkpolicy.
*/}}
{{- define "networkPolicy.apiVersion" -}}
{{- if semverCompare ">=1.4-0, <1.7-0" .Capabilities.KubeVersion.GitVersion -}}
{{- print "extensions/v1beta1" -}}
{{- else -}}
{{- print "networking.k8s.io/v1" -}}
{{- end -}}
{{- end -}}

{{/*
Return the proper image name (for the metrics image)
*/}}
{{- define "nats.metrics.image" -}}
{{- $registryName := .Values.metrics.image.registry -}}
{{- $repositoryName := .Values.metrics.image.repository -}}
{{- $tag := .Values.metrics.image.tag | toString -}}
{{/*
Helm 2.11 supports the assignment of a value to a variable defined in a different scope,
but Helm 2.9 and 2.10 doesn't support it, so we need to implement this if-else logic.
Also, we can't use a single if because lazy evaluation is not an option
*/}}
{{- if .Values.global }}
    {{- if .Values.imageRegistry }}
        {{- printf "%s/%s:%s" .Values.imageRegistry $repositoryName $tag -}}
    {{- else -}}
        {{- printf "%s/%s:%s" $registryName $repositoryName $tag -}}
    {{- end -}}
{{- else -}}
    {{- printf "%s/%s:%s" $registryName $repositoryName $tag -}}
{{- end -}}
{{- end -}}


{{/*
Compile all warnings into a single message, and call fail.
*/}}
{{- define "nats.validateValues" -}}
{{- $messages := list -}}
{{- $messages := append $messages (include "nats.validateValues.resourceType" .) -}}
{{- $messages := without $messages "" -}}
{{- $message := join "\n" $messages -}}

{{- if $message -}}
{{-   printf "\nVALUES VALIDATION:\n%s" $message | fail -}}
{{- end -}}
{{- end -}}

{{/* Validate values of NATS - must provide a valid resourceType ("deployment" or "statefulset") */}}
{{- define "nats.validateValues.resourceType" -}}
{{- if and (ne .Values.resourceType "deployment") (ne .Values.resourceType "statefulset") -}}
nats: resourceType
    Invalid resourceType selected. Valid values are "deployment" and
    "statefulset". Please set a valid mode (--set resourceType="xxxx")
{{- end -}}
{{- end -}}

{{/*
Return the apiVersion
*/}}
{{- define "statefulset.apiVersion" -}}
{{- if .Capabilities.APIVersions.Has "apps/v1" -}}
    {{- print "apps/v1" -}}
{{- else -}}
    {{- print "apps/v1beta2" -}}
{{- end -}}
{{- end -}}

{{- /*
Create labels for usage in metadata.
*/ -}}
{{- define "nats.labels.selector" -}}
system: "any"
subsystem: "any"
name: "{{ template "nats.name" . }}"
release: {{ .Release.Name | quote }}
{{- end -}}

{{- define "nats.labels" -}}
{{ template "nats.labels.selector" . }}
chart: "{{ template "nats.chart" . }}"
version: {{ .Values.image.tag | quote }}
heritage: {{ .Release.Service | quote }}
{{- if .Values.labels }}
{{ toYaml .Values.labels }}
{{- end }}
{{- end -}}
