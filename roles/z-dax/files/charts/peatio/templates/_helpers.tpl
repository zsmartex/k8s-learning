{{/*
Expand the name of the chart.
*/}}
{{- define "peatio.name" -}}
{{- printf "peatio" -}}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "peatio.fullname" -}}
{{- printf "peatio" -}}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "peatio.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "peatio.labels" -}}
helm.sh/chart: {{ include "peatio.chart" . }}
{{ include "peatio.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "peatio.selectorLabels" -}}
app.kubernetes.io/name: {{ include "peatio.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "peatio.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "peatio.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Environment for peatio container
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
Environment for peatio rails container
*/}}
{{- define "server.env" -}}
- name: KAIGARA_APP_NAME
  value: {{ default "peatio" .Values.kaigara.peatioAppName }}
{{ include "env" . }}
{{- end -}}

{{/*
Environment for peatio daemon container
*/}}
{{- define "daemons.env" -}}
- name: KAIGARA_APP_NAME
  value: {{ default "peatio,peatio_daemons" .Values.kaigara.daemonsAppName }}
{{ include "env" . }}
{{- end -}}

{{/*
Environment for peatio prepare db container
*/}}
{{- define "prepare.env" -}}
- name: KAIGARA_APP_NAME
  value: {{ default "peatio,peatio_seed" .Values.kaigara.daemonsAppName }}
{{ include "env" . }}
{{- end -}}
