##
## —————————————————————————————————— ZSMARTEX STACK ————————————————————————————————
##

.DEFAULT_GOAL = help

.PHONY: help header-env
help: ## Display help
	@grep -E '(^[0-9a-zA-Z_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | sed -e 's/Makefile://' | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-22s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'

header-env:
	@echo "—————————————————————————————————— ZSMARTEX STACK —————————————————————————————————"
	@echo

separator = "————————————————————————————————————————————————————————————————————————————————"

.PHONY: venv-check
venv-check: header-env
	@[ -d "$${PWD}/.direnv" ] || (echo "Venv not found: $${PWD}/.direnv" && exit 1)
	@direnv reload

.PHONY: prepare
prepare: venv-check ### Install workspace env dependencies
	@echo "—————————————————————————————— PYTHON REQUIREMENTS ———————————————————————————"
	@pip3 install -U pip --no-cache-dir --break-system-packages --quiet &&\
	echo "[  ${Green}OK${Color_Off}  ] ${Yellow}INSTALL${Color_Off} PIP3" || \
	echo "[${Red}FAILED${Color_Off}] ${Yellow}INSTALL${Color_Off} PIP3"

	@pip3 install -U wheel --no-cache-dir --break-system-packages --quiet &&\
	echo "[  ${Green}OK${Color_Off}  ] ${Yellow}INSTALL${Color_Off} WHEEL" || \
	echo "[${Red}FAILED${Color_Off}] ${Yellow}INSTALL${Color_Off} WHEEL"

	@pip3 install -U setuptools --no-cache-dir --break-system-packages --quiet &&\
	echo "[  ${Green}OK${Color_Off}  ] ${Yellow}INSTALL${Color_Off} SETUPTOOLS" || \
	echo "[${Red}FAILED${Color_Off}] ${Yellow}INSTALL${Color_Off} SETUPTOOLS"

	@pip3 install -U --no-cache-dir --break-system-packages -q -r requirements.txt &&\
	echo "[  ${Green}OK${Color_Off}  ] ${Yellow}INSTALL${Color_Off} PIP REQUIREMENTS" || \
	echo "[${Red}FAILED${Color_Off}] ${Yellow}INSTALL${Color_Off} PIP REQUIREMENTS"

	@echo "————————————————————————————— ANSIBLE REQUIREMENTS ———————————————————————————"
	@ansible-galaxy collection install -fr ${PWD}/requirements.yml
	@ansible-galaxy role install -fr ${PWD}/requirements.yml

	helm plugin install https://github.com/databus23/helm-diff

##
## ——————————————————————————————— STAGE_0 - INIT ———————————————————————————————
##
.PHONY: init_instance
init_instance: ## Init inventory dir for instance
	ansible-playbook playbooks/00_init_instance.yml

.PHONY: 10_base
10_base: ## Install istio + nginx + kiali + monitoring for kubernetes
	ansible-playbook ../../playbooks/10_base_install.yml

.PHONY: 11_vault
11_vault: ## Setup vault
	ansible-playbook ../../playbooks/11_vault_setup.yml
