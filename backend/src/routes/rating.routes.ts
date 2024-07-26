import { Router } from 'express';
import { UserRatingService } from '../services/userRating.service';
import { RatingController } from '../controller/rating.controller';
import {
	bodyRatingValidator,
	isMongoId,
	updateBodyRatingValidator
} from '../middlewares/validators';
import { checkRol } from '../middlewares/checkRol';
import { RefugioRatingService } from '../services/refugioRating.service';

export class RatingRouter {
	static get routes(): Router {
		const router = Router();
		const userRatingService = new UserRatingService();
		const refugioRatingService = new RefugioRatingService();
		const controller = new RatingController(
			userRatingService,
			refugioRatingService
		);
		/* User Rating */
		router.get(
			'/user',
			checkRol(['Gerente', 'Admin']),
			controller.getAllUserRating
		);
		router.get(
			'/user/rate',
			checkRol(['Gerente', 'Admin']),
			controller.getAllAverageUserRating
		);
		router.get(
			'/user/rate/:id',
			checkRol(['Gerente', 'Admin']),
			isMongoId,
			controller.getAllUserRating
		);
		router.post(
			'/user',
			checkRol(['User']),
			bodyRatingValidator,
			controller.createUserRating
		);
		router.get(
			'/user/:id',
			checkRol(['Gerente', 'Admin']),
			isMongoId,
			controller.getByIdUserRating
		);
		router.put(
			'/user/:id',
			checkRol(['Gerente', 'Admin']),
			isMongoId,
			updateBodyRatingValidator,
			controller.updateUserRating
		);
		router.delete(
			'/user/:id',
			checkRol(['User']),
			isMongoId,
			controller.deleteUserRating
		);

		/* Refugio Rating */

		router.get(
			'/refugio',
			checkRol(['Admin', 'Gerente']),
			controller.getAllRefugioRating
		);
		router.get(
			'/refugio/rate',
			checkRol(['Admin', 'Gerente']),
			controller.getAllAverageRefugioRating
		);
		router.get(
			'/refugio/rate/:id',
			checkRol(['Admin', 'Gerente']),
			isMongoId,
			controller.getAverageRefugioRating
		);
		router.post(
			'/refugio',
			checkRol(['Admin', 'Gerente']),
			bodyRatingValidator,
			controller.createRefugioRating
		);
		router.get(
			'/refugio/:id',
			checkRol(['Admin', 'Gerente']),
			isMongoId,
			controller.getByIdRefugioRating
		);
		router.put(
			'/refugio/:id',
			checkRol(['Admin', 'Gerente']),
			isMongoId,
			updateBodyRatingValidator,
			controller.updateRefugioRating
		);
		router.delete(
			'/refugio/:id',
			checkRol(['Admin', 'Gerente']),
			isMongoId,
			controller.deleteRefugioRating
		);

		return router;
	}
}
