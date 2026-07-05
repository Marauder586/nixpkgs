{
  lib,
  buildPythonPackage,
  fetchPypi,
  hatchling,
  hatch-vcs,
  hypothesis,
  pytest-timeout,
  pytest-xdist,
  pytestCheckHook,
  setuptools,
}:

buildPythonPackage rec {
  pname = "chardet";
  version = "6.0.0.post1";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-a3gEjDyXx7LtH7rXoY929aZUf30026tTbME4h8mpL6Q=";
  };

  nativeBuildInputs = [
    setuptools
    hatchling
    hatch-vcs
  ];

  nativeCheckInputs = [
    hypothesis
    pytest-timeout
    pytest-xdist
    pytestCheckHook
  ];

  disabledTests = [
    # flaky; https://github.com/chardet/chardet/issues/256
    "test_detect_all_and_detect_one_should_agree"
  ];

  pythonImportsCheck = [ "chardet" ];

  meta = {
    changelog = "https://github.com/chardet/chardet/releases/tag/${version}";
    description = "Universal encoding detector";
    mainProgram = "chardetect";
    homepage = "https://github.com/chardet/chardet";
    license = lib.licenses.lgpl21Plus;
    maintainers = [ ];
  };
}
