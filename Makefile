VERSION=0.0.1
docker-build:
	@docker build -t eqemudevcontainer .
docker-push: docker-build
	@docker tag eqemudevcontainer eqemu/devcontainer:$(VERSION)
	@docker push eqemu/devcontainer:$(VERSION)
	@docker tag eqemudevcontainer eqemu/devcontainer:latest
	@docker push eqemu/devcontainer:latest