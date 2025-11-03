.PHONY: setup
setup: pub_get build_runner

.PHONY: pub_get
pub_get:
	fvm flutter pub get

.PHONY: build_runner
build_runner:
	fvm dart run build_runner build --delete-conflicting-outputs;