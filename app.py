
from potassium import Potassium, Request, Response

app = Potassium("my_app")

@app.init
def init() -> dict:
    context = {
    }
    return context
    
@app.handler()
def handler(context: dict, request: Request) -> Response:
    return Response(json={"outputs": "test"}, status=200)

if __name__ == "__main__":
    app.serve()