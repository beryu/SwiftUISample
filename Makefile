.PHONY: setup
setup: ## Install build tools and generate project
	@echo "🚀 Starting setup..."
	@brew install mint
	@mint bootstrap
	@make generate
	@echo "✅ Setup has completed!"

.PHONY: generate
generate: ## Generate Xcode project
	@echo "🚀 Starting Xcode project generation..."
	@mint run xcodegen generate
	@echo "✅ Generation has completed!"

