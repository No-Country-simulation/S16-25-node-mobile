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

	getAll = (req: Request, res: Response) => {
		this.animalService
			.getAnimals()
			.then(animals => res.json(animals))
			.catch(error => this.handleError(error, res));
	};

	create = (req: Request, res: Response) => {
		const { body } = req;
		body.image = req.file;
		this.animalService
			.create(body)
			.then(animal => res.status(201).json(animal))
			.catch(error => this.handleError(error, res));
	};

	getById = (req: Request, res: Response) => {
		const { id } = req.params;

		this.animalService
			.getById(id)
			.then(animal => res.json(animal))
			.catch(error => this.handleError(error, res));
	};

	update = (req: Request, res: Response) => {
		const { id } = req.params;
		const { body } = req;
		body.image = req.file;

		this.animalService
			.update(id, body)
			.then(animal => res.status(202).json(animal))
			.catch(error => this.handleError(error, res));
	};

	delete = (req: Request, res: Response) => {
		const { id } = req.params;

		this.animalService
			.delete(id)
			.then(() => res.status(202).json({ message: 'Animal Eliminado' }))
			.catch(error => this.handleError(error, res));
	};
}
