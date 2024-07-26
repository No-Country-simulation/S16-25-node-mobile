import { Request, Response } from 'express';
import { UserRatingService } from '../services/userRating.service';
import { CustomError } from '../utils/custom.error';
import { RefugioRatingService } from '../services/refugioRating.service';

export class RatingController {
	constructor(
		private readonly userRatingService: UserRatingService,
		private readonly refugioRatingService: RefugioRatingService
	) {}

	private handleError = (error: unknown, res: Response) => {
		if (error instanceof CustomError) {
			return res.status(error.statusCode).json({ message: error.message });
		} else {
			console.log(`${error}`);
			return res.status(500).json({ error: 'Internal server error' });
		}
	};

	/* UserRating */
	getAllUserRating = (req: Request, res: Response) => {
		this.userRatingService
			.geAll()
			.then(ratings => res.json(ratings))
			.catch(error => this.handleError(error, res));
	};

	getAverageUserRating = (req: Request, res: Response) => {
		const { id } = req.params;

		this.userRatingService
			.getAverageByRefugio(id)
			.then(average => res.json(average))
			.catch(error => this.handleError(error, res));
	};

	getAllAverageUserRating = (req: Request, res: Response) => {
		this.userRatingService
			.getAllAverage()
			.then(average => res.json(average))
			.catch(error => this.handleError(error, res));
	};

	createUserRating = (req: Request, res: Response) => {
		const { body } = req;
		body.user = req.user;

		this.userRatingService
			.create(body)
			.then(rating => res.status(201).json(rating))
			.catch(error => this.handleError(error, res));
	};

	getByIdUserRating = (req: Request, res: Response) => {
		const { id } = req.params;

		this.userRatingService
			.getById(id)
			.then(rating => res.json(rating))
			.catch(error => this.handleError(error, res));
	};

	updateUserRating = (req: Request, res: Response) => {
		const { id } = req.params;
		const { body } = req;

		this.userRatingService
			.update(id, body)
			.then(rating => res.status(202).json(rating))
			.catch(error => this.handleError(error, res));
	};

	deleteUserRating = (req: Request, res: Response) => {
		const { id } = req.params;

		this.userRatingService
			.delete(id)
			.then(() => res.status(202).json({ message: 'Calificacion eliminado' }))
			.catch(error => this.handleError(error, res));
	};

	/* RefugioRating */

	getAllRefugioRating = (req: Request, res: Response) => {
		this.refugioRatingService
			.geAll()
			.then(ratings => res.json(ratings))
			.catch(error => this.handleError(error, res));
	};

	getAverageRefugioRating = (req: Request, res: Response) => {
		const { id } = req.params;

		this.refugioRatingService
			.getAverageByUser(id)
			.then(average => res.json(average))
			.catch(error => this.handleError(error, res));
	};

	getAllAverageRefugioRating = (req: Request, res: Response) => {
		this.refugioRatingService
			.getAllAverage()
			.then(average => res.json(average))
			.catch(error => this.handleError(error, res));
	};

	createRefugioRating = (req: Request, res: Response) => {
		const { body } = req;
		body.user = req.user;

		this.refugioRatingService
			.create(body)
			.then(rating => res.status(201).json(rating))
			.catch(error => this.handleError(error, res));
	};

	getByIdRefugioRating = (req: Request, res: Response) => {
		const { id } = req.params;

		this.refugioRatingService
			.getById(id)
			.then(rating => res.json(rating))
			.catch(error => this.handleError(error, res));
	};

	updateRefugioRating = (req: Request, res: Response) => {
		const { id } = req.params;
		const { body } = req;

		this.refugioRatingService
			.update(id, body)
			.then(rating => res.status(202).json(rating))
			.catch(error => this.handleError(error, res));
	};

	deleteRefugioRating = (req: Request, res: Response) => {
		const { id } = req.params;

		this.refugioRatingService
			.delete(id)
			.then(() => res.status(202).json({ message: 'Calificacion eliminado' }))
			.catch(error => this.handleError(error, res));
	};
}
