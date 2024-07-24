import { Router } from 'express';
import { UserService } from '../services/user.service';
import { UserController } from '../controller/user.controller';
import { updateUserValidator } from '../middlewares/validators';
import { HandleInputErrors } from '../middlewares/validateInput';
import upload from '../middlewares/handleFile';

export class UserRouter {
	static get routes(): Router {
		const router = Router();
		const userService = new UserService();
		const controller = new UserController(userService);
		//TODO: agregar chequeo de rol admin
		//TODO: agregar ruta para atualziar solo contraseña
		router.get('/', controller.getAll);
		router.get('/:id', controller.getById);
		router.put(
			'/:id',
			upload.single('imagenPerfil'),
			updateUserValidator,
			HandleInputErrors,
			controller.update
		);
		router.delete('/:id', controller.delete);

		return router;
	}
}
