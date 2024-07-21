import { Router } from 'express';
import { RatingService } from '../services/rating.service';
import { RatingController } from '../controller/rating.controller';

export class RatingRouter {
	static get routes(): Router {
		const router = Router();
		const ratingService = new RatingService();
		const controller = new RatingController(ratingService);

		router.get('/', controller.getAll);
		router.post('/', controller.create);
		router.get('/:id', controller.getById);
		router.put('/:id', controller.update);
		router.delete('/:id', controller.delete);

		return router;
	}
}
