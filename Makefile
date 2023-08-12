GOLANG_CROSS_VERSION ?= v1.21.0

test-release:
	@docker run \
		--rm \
		--privileged \
		-v ${PWD}:/smtp_to_telegram \
		-w /smtp_to_telegram \
		-e GITHUB_TOKEN \
		-e DOCKER_USERNAME \
		-e DOCKER_PASSWORD \
		-e DOCKER_REGISTRY \
		-v /var/run/docker.sock:/var/run/docker.sock \
		goreleaser/goreleaser-cross:${GOLANG_CROSS_VERSION} \
		--clean --skip-validate --timeout=1h --snapshot