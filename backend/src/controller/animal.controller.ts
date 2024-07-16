import { Request, Response } from 'express';
import { CustomError } from '../utils/custom.error';
import { AnimalService } from '../services/animal.service';

export class AnimalController {
	constructor(private readonly animalService: AnimalService) {}

	private handleError = (error: unknown, res: Response) => {
		if (error instanceof CustomError) {
			return res.status(error.statusCode).json({ error: error.message });
		} else {
			console.log(`${error}`);
			return res.status(500).json({ error: 'Internal server error' });
		}
	};

	get = (req: Request, res: Response) => {
		this.animalService
			.getAnimals()
			.then(animals => res.json(animals))
			.catch(err => this.handleError(err, res));
	};

	create = (req: Request, res: Response) => {
		const { body } = req;
		body.image = req.file;
		this.animalService
			.create(body)
			.then(animal => res.status(201).json(animal))
			.catch(err => this.handleError(err, res));
	};
}
