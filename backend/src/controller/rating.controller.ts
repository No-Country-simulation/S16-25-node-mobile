import { Request, Response } from 'express';
import { RatingService } from '../services/rating.service';
import { CustomError } from '../utils/custom.error';

export class RatingController {
	constructor(private readonly ratingService: RatingService) {}

	private handleError = (error: unknown, res: Response) => {
		if (error instanceof CustomError) {
			return res.status(error.statusCode).json({ message: error.message });
		} else {
			console.log(`${error}`);
			return res.status(500).json({ error: 'Internal server error' });
		}
	};

	getAll = (req: Request, res: Response) => {
		this.ratingService
			.geAll()
			.then(ratings => res.json(ratings))
			.catch(error => this.handleError(error, res));
	};

	create = (req: Request, res: Response) => {
		const { body } = req;

		this.ratingService
			.create(body)
			.then(rating => res.status(201).json(rating))
			.catch(error => this.handleError(error, res));
	};

	getById = (req: Request, res: Response) => {
		const { id } = req.params;

		this.ratingService
			.getById(id)
			.then(rating => res.json(rating))
			.catch(error => this.handleError(error, res));
	};

	update = (req: Request, res: Response) => {
		const { id } = req.params;
		const { body } = req;

		this.ratingService
			.update(id, body)
			.then(rating => res.status(202).json(rating))
			.catch(error => this.handleError(error, res));
	};

	delete = (req: Request, res: Response) => {
		const { id } = req.params;

		this.ratingService
			.delete(id)
			.then(() => res.status(202).json({ message: 'Calificacion eliminado' }))
			.catch(error => this.handleError(error, res));
	};
}
