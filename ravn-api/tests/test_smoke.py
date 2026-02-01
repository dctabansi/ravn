import ravn_api
import ravn_engine
import ravn_train


def test_engine_bridge() -> None:
    assert ravn_engine.add(10, 20) == 30


def test_packages_importable() -> None:
    assert ravn_api is not None
    assert ravn_train is not None
