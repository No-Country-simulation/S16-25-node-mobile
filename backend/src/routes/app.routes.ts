import { Router } from 'express';
import { AnimalRouter } from './animal.routes';

export class AppRoutes {
	static get routes(): Router {
		const router = Router();

		// Definir las rutas
		router.use('/animal', AnimalRouter.routes);

		return router;
	}
}
