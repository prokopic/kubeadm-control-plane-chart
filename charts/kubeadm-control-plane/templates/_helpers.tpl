{{/*
    Print control plane name.
    We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "kubeadm.control-plane.metadata.name" -}}
{{- .Values.metadata.name | default .Values.global.metadata.name | default .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
    Print namespace where the resources are deployed to.
    We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "kubeadm.control-plane.metadata.namespace" -}}
{{- .Values.metadata.namespace | default .Values.global.metadata.namespace | default .Release.Namespace | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "kubeadm.control-plane.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "kubeadm.control-plane.metadata.labels" -}}
helm.sh/chart: {{ include "kubeadm.control-plane.chart" . }}
{{ include "kubeadm.control-plane.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "kubeadm.control-plane.selectorLabels" -}}
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "kubeadm.control-plane.metadata.template-name" -}}
{{- include "kubeadm.control-plane.metadata.name" . }}-controlplane
{{- end }}
