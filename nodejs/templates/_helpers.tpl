{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "service.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "service.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "service.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "service.labels" -}}
helm.sh/chart: {{ include "service.chart" . }}
{{ include "service.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
TLS secret name
*/}}
{{- define "service.tlsSecretName" -}}
{{- printf "%s" .Chart.Name | replace "+" "_" | trunc 63 | trimSuffix "-" -}}-cert
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "service.selectorLabels" -}}
app.kubernetes.io/name: {{ include "service.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "service.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "service.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}


{{/*
Create the name of the service to use
*/}}
{{- define "service.serviceName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "service.fullname" .) .Values.service.name }}
{{- else }}
{{- default "default" .Values.service.name }}
{{- end }}
{{- end }}



{{/*
Create the name of the mapping to use
*/}}
{{- define "service.mappingName" -}}
{{- if .Values.service.mapping.enable }}
{{- default (include "service.fullname" .) .Values.service.mapping.name }}
{{- else }}
{{- default "default" .Values.service.mapping.name }}
{{- end }}
{{- end }}

{{/*
Create the hostname of the mapping to use
*/}}
{{- define "service.mappingHostname" -}}
{{- if and .Values.service.create .Values.service.mapping.enable }}
{{- printf "*" }} {{- default .Release.Name .Values.service.mapping.hostname }}
{{- else }}
{{- default "*" .Values.service.mapping.prefix }}
{{- end }}
{{- end }}

{{/*
Create the prefix of the mapping to use
*/}}
{{- define "service.mappingPrefix" -}}
{{- if and .Values.service.create .Values.service.mapping.enable }}
{{- printf "/" }} {{- default .Release.Name .Values.service.mapping.prefix }}
{{- else }}
{{- default "default" .Values.service.mapping.prefix }}
{{- end }}
{{- end }}
