{
  lib,
  stdenv,
  buildPythonPackage,
  fetchFromGitHub,
  pytestCheckHook,
  devtools,
  fastapi,
  httpx2,
  poetry-core,
  prometheus-client,
  requests,
  starlette,
}:

buildPythonPackage rec {
  pname = "prometheus-fastapi-instrumentator";
  version = "8.0.2";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "trallnag";
    repo = "prometheus-fastapi-instrumentator";
    tag = "v${version}";
    hash = "sha256-fTJjAM1jUZXfhjLo9xqlu45LaoqZ330ogOA6x7aByqw=";
  };

  build-system = [
    poetry-core
  ];

  dependencies = [
    prometheus-client
    starlette
  ];

  nativeCheckInputs = [
    devtools
    fastapi
    httpx2
    pytestCheckHook
    requests
  ];

  # numerous test failures on Darwin
  doCheck = stdenv.hostPlatform.isLinux;

  pythonImportsCheck = [ "prometheus_fastapi_instrumentator" ];

  meta = {
    description = "Instrument FastAPI with Prometheus metrics";
    homepage = "https://github.com/trallnag/prometheus-fastapi-instrumentator";
    changelog = "https://github.com/trallnag/prometheus-fastapi-instrumentator/blob/${src.tag}/CHANGELOG.md";
    license = with lib.licenses; [
      isc
      bsd3
    ];
    maintainers = with lib.maintainers; [ bcdarwin ];
    platforms = lib.platforms.unix;
  };
}
