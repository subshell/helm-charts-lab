{{/*
Expand the name of the chart.
*/}}
{{- define "knowledge-base.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "knowledge-base.fullname" -}}
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

{{- define "knowledge-base.fullname.frontend" -}}
{{- $fullname := include "knowledge-base.fullname" . }}
{{- printf "%s-%s" $fullname "frontend" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "knowledge-base.fullname.api" -}}
{{- $fullname := include "knowledge-base.fullname" . }}
{{- printf "%s-%s" $fullname "api" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "knowledge-base.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels API
*/}}
{{- define "knowledge-base-api.labels" -}}
helm.sh/chart: {{ include "knowledge-base.chart" . }}
{{ include "knowledge-base-api.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Common labels Frontend
*/}}
{{- define "knowledge-base-frontend.labels" -}}
helm.sh/chart: {{ include "knowledge-base.chart" . }}
{{ include "knowledge-base-frontend.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels API
*/}}
{{- define "knowledge-base-api.selectorLabels" -}}
app.kubernetes.io/name: "{{ include "knowledge-base.name" . }}-api"
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Selector labels Frontend
*/}}
{{- define "knowledge-base-frontend.selectorLabels" -}}
app.kubernetes.io/name: "{{ include "knowledge-base.name" . }}-frontend"
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
