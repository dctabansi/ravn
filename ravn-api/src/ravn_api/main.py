import ravn_engine


def main() -> None:
    print("Hello from ravn-api!")
    result = ravn_engine.add(10, 20)
    print(result)


if __name__ == "__main__":
    main()
