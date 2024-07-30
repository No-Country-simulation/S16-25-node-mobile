import { Router } from "express";
import { AdopcionController } from "../controller/adopcion.controller";
import { AdopcionService } from "../services/adopcion.service";

import { checkToken } from "../middlewares/checkToken";

export class AdopcionRoutes {
    static get routes(): Router {
        const router = Router();
        const adopcionService = new AdopcionService();
        const controller = new AdopcionController(adopcionService);
        router.post("/", controller.create
        );
        router.get("/", controller.getAll);
        router.get("/:id", controller.getById);
        router.put("/:id", controller.update);
        router.delete(":id", controller.delete);
        return router;
    }
}