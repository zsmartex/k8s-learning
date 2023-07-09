{{/*
Expand the name of the chart.
*/}}
{{- define "kouda.name" -}}
{{- printf "kouda" -}}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "kouda.fullname" -}}
{{- printf "kouda" -}}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "kouda.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "kouda.labels" -}}
helm.sh/chart: {{ include "kouda.chart" . }}
{{ include "kouda.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "kouda.selectorLabels" -}}
app.kubernetes.io/name: {{ include "kouda.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "kouda.serviceAccountName" -}}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}

{{/*
Environment for kouda container
*/}}
{{- define "env" -}}
- name: KAIGARA_STORAGE_DRIVER
  value: {{ default "vault" .Values.global.kaigaraSecretStore }}
- name: KAIGARA_VAULT_ADDR
  value: {{ printf "http://%s:8200" .Values.global.infra.vaultHost }}
- name: KAIGARA_VAULT_TOKEN
  valueFrom:
    secretKeyRef:
      name: {{ .Values.global.secretPrefix }}-global
      key: kaigaraVaultToken
- name: KAIGARA_DEPLOYMENT_ID
  value: {{ default "z-dax" .Values.global.deploymentId }}
- name: KAIGARA_SCOPES
  value: {{ default "private,secret" .Values.kaigara.scopes }}
# TODO: remove soon during k8s problem need to repeat
- name: QUESTDB_PORT
  value: "9000"
{{- end -}}

{{/*
Environment for kouda rails container
*/}}
{{- define "server.env" -}}
- name: KAIGARA_APP_NAME
  value: {{ default "kouda" .Values.kaigara.appName }}
{{ include "env" . }}
{{- end -}}

{{/*
Environment for kouda prepare db container
*/}}
{{- define "prepare.env" -}}
- name: KAIGARA_APP_NAME
  value: {{ default "kouda,kouda_prepare" .Values.kaigara.prepareAppName }}
{{ include "env" . }}
{{- end -}}
