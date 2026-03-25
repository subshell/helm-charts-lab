{{/*
Expand the name of the chart.
*/}}
{{- define "dependency-db.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "dependency-db.fullname" -}}
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

{{- define "dependency-db.fullname.frontend" -}}
{{- $fullname := include "dependency-db.fullname" . }}
{{- printf "%s-%s" $fullname "frontend" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "dependency-db.fullname.api" -}}
{{- $fullname := include "dependency-db.fullname" . }}
{{- printf "%s-%s" $fullname "api" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "dependency-db.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels API
*/}}
{{- define "dependency-db-api.labels" -}}
helm.sh/chart: {{ include "dependency-db.chart" . }}
{{ include "dependency-db-api.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Common labels Frontend
*/}}
{{- define "dependency-db-frontend.labels" -}}
helm.sh/chart: {{ include "dependency-db.chart" . }}
{{ include "dependency-db-frontend.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels API
*/}}
{{- define "dependency-db-api.selectorLabels" -}}
app.kubernetes.io/name: "{{ include "dependency-db.name" . }}-api"
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Selector labels Frontend
*/}}
{{- define "dependency-db-frontend.selectorLabels" -}}
app.kubernetes.io/name: "{{ include "dependency-db.name" . }}-frontend"
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
