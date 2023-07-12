.PHONY: setup
setup: ## Install build tools and generate project
	@echo "🚀 Starting setup..."
	@brew install mint
	@mint bootstrap
	@xcodegen generate
	@echo "✅ Setup has completed!"
