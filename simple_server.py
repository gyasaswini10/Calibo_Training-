import asyncio
from mcp import ClientSession, StdioServerParameters

async def main():
    # Launch the server as a subprocess
    server = StdioServerParameters(
        command="python",
        args=["simple_server.py"]
    )
    async with ClientSession(server) as session:
        await session.initialize()
        
        # List tools (discovery)
        tools = await session.list_tools()
        print("Available tools:", [t.name for t in tools])
        
        # Call the add tool
        result = await session.call_tool("add", arguments={"a": 5, "b": 3})
        print("Result:", result.content[0].text)

asyncio.run(main())
# import asyncio
# from mcp import ClientSession, StdioServerParameters
# from mcp.client.stdio import stdio_client

# async def main():
#     server = StdioServerParameters(
#         command="python",
#         args=["simple_server.py"]
#     )

#     async with stdio_client(server) as (read, write):
        
#         async with ClientSession(read, write) as session:
#             await session.initialize()

#             tools = await session.list_tools()
#             print("Available tools:", [t.name for t in tools])

#             result = await session.call_tool("add", arguments={"a": 5, "b": 3})
#             print("Result:", result.content[0].text)

# asyncio.run(main())