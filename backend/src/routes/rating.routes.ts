import { Router } from 'express';
import { RatingService } from '../services/rating.service';
import { RatingController } from '../controller/rating.controller';
import {
	bodyRatingValidator,
	isMongoId,
	updateBodyRatingValidator
} from '../middlewares/validators';

export class RatingRouter {
	static get routes(): Router {
		const router = Router();
		const ratingService = new RatingService();
		const controller = new RatingController(ratingService);

		router.get('/', controller.getAll);
		router.post('/', bodyRatingValidator, controller.create);
		router.get('/:id', isMongoId, controller.getById);
		router.put('/:id', isMongoId, updateBodyRatingValidator, controller.update);
		router.delete('/:id', isMongoId, controller.delete);

		return router;
	}
}
