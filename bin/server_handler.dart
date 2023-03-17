import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class ServeHandler {
  Handler get handler {
    final router = Router();

    router.get("/", (Request request) {
      return Response(200, body: "Primeira Rota");
    });

    // http://localhost:8080/ola/mundo
    //ola mundo
    router.get("/ola/mundo/<usuario>", (Request req, String usuario) {
      return Response.ok("Olá Mundo $usuario");
    });

    // http://localhost:8080/query?nome=Paulo
    router.get("/query", (Request req) {
      String? nome = req.url.queryParameters["nome"];
      String? idade = req.url.queryParameters["idade"];
      return Response.ok("Query eh: $nome, idade $idade");
    });

    router.post("/login", (Request req) async {
      var result = await req.readAsString();
      Map json = jsonDecode(result);

      var usuario = json["usuario"];
      var senha = json["senha"];
      //se usuario == admin e senha == 123
      if (usuario == "admin" && senha == "1234") {
        return Response.ok("Bem Vindo $usuario");
      } else {
        return Response.forbidden("Acesso negado");
      }
      //se não
    });
    return router;
  }
}
