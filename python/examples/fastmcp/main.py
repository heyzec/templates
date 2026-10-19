import argparse

from fastmcp import FastMCP

mcp = FastMCP("example-fastmcp")


@mcp.tool()
def add(a: int, b: int) -> int:
    """Add a and b and return their sum"""
    return a + b


def main():
    parser = argparse.ArgumentParser(description="FastMCP Example")

    subparsers = parser.add_subparsers(dest="cmd")
    _ = subparsers.add_parser("mcp", help="Start the FastMCP server")

    args = parser.parse_args()

    if args.cmd is None:
        parser.print_help()
        return

    if args.cmd == "mcp":
        mcp.run()


if __name__ == "__main__":
    main()
