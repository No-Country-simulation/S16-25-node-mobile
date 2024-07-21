import { Router } from 'express';
import { RefugioService } from '../services/refugio.service';
import { RefugioController } from '../controller/refugio.controller';

export class RefugioRouter {
	static get routes(): Router {
		const router = Router();
		const refugioService = new RefugioService();
		const controller = new RefugioController(refugioService);

		router.get('/', controller.getAll);
		router.post('/', controller.create);
		router.get('/:id', controller.getById);
		router.put('/:id', controller.update);
		router.delete('/:id', controller.delete);

		return router;
	}
}
