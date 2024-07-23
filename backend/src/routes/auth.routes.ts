import { Router } from "express";
import { AuthService } from "../services/auth.service";
import { AuthController } from "../controller/auth.controller";

export class AuthRoutes {

    static get routes(): Router {

        const router = Router();
        const authService = new AuthService();
        const controller = new AuthController(authService);

        router.post('/login', controller.login);
        router.post('/register', controller.register);
        return router;
    }

}