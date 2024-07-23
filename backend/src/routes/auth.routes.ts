import { Router } from "express";
import { AuthService } from "../services/auth.service";
import { AuthController } from "../controller/auth.controller";
import { loginUserValidator, registerUserValidator } from "../middlewares/validators";
import { HandleInputErrors } from "../middlewares/validateInput";

export class AuthRoutes {

    static get routes(): Router {

        const router = Router();
        const authService = new AuthService();
        const controller = new AuthController(authService);

        router.post('/login', loginUserValidator, HandleInputErrors, controller.login);
        router.post('/register', registerUserValidator, HandleInputErrors, controller.register);
        return router;
    }

}