import { Router } from 'express';
import { AnimalRouter } from './animal.routes';
import { UserRouter } from './user.routes';
import { AuthRoutes } from './auth.routes';

export class AppRoutes {
	static get routes(): Router {
		const router = Router();

		// Definir las rutas
		router.use('/animal', AnimalRouter.routes);
		router.use('/user', UserRouter.routes);
		router.use('/auth', AuthRoutes.routes);

		return router;
	}
}
