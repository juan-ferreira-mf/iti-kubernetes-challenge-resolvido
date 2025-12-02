{{/*

*/}}
{{- define "iti-kubernetes-challenge.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*

*/}}
{{- define "iti-kubernetes-challenge.fullname" -}}
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

*/}}
{{- define "iti-kubernetes-challenge.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*

*/}}
{{- define "iti-kubernetes-challenge.labels" -}}
helm.sh/chart: {{ include "iti-kubernetes-challenge.chart" . }}
{{ include "iti-kubernetes-challenge.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*

*/}}
{{- define "iti-kubernetes-challenge.selectorLabels" -}}
app.kubernetes.io/name: {{ include "iti-kubernetes-challenge.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

