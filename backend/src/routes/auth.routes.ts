import { Router } from 'express';
import { AuthService } from '../services/auth.service';
import { AuthController } from '../controller/auth.controller';
import {
	loginUserValidator,
	registerUserValidator
} from '../middlewares/validators';
import { HandleInputErrors } from '../middlewares/validateInput';
import upload from '../middlewares/handleFile';
import { checkToken } from '../middlewares/checkToken';

export class AuthRoutes {
	static get routes(): Router {
		const router = Router();
		const authService = new AuthService();
		const controller = new AuthController(authService);

		router.post(
			'/login',
			loginUserValidator,
			HandleInputErrors,
			controller.login
		);
		router.post(
			'/register',
			upload.single('imagenPerfil'),
			registerUserValidator,
			HandleInputErrors,
			controller.register
		);

		router.get('/profile', checkToken, controller.getProfile);
		return router;
	}
}
