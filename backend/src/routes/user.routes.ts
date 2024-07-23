import { Router } from "express";
import { UserService } from "../services/user.service";
import { UserController } from "../controller/user.controller";

export class UserRouter {

    static get routes(): Router {

        const router = Router();
        const userService = new UserService();
        const controller = new UserController(userService);
//TODO: agregar chequeo de rol admin
        router.get('/', controller.getAll);
        router.get('/:id', controller.getById);
        router.put('/:id', controller.update);
        router.delete('/:id', controller.delete);

        return router;

    }
    
};
