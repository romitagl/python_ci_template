from src.app import hello_world, main


def test_main():
    main(None)


def test_hello_world():
    assert hello_world() == "hello world"
