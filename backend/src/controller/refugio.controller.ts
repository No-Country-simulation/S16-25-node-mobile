import { Request, Response } from 'express';
import { RefugioService } from '../services/refugio.service';
import { CustomError } from '../utils/custom.error';

export class RefugioController {
	constructor(private readonly refugioService: RefugioService) {}

	private handleError = (error: unknown, res: Response) => {
		if (error instanceof CustomError) {
			return res.status(error.statusCode).json({ message: error.message });
		} else {
			console.log(`${error}`);
			return res.status(500).json({ error: 'Internal server error' });
		}
	};

	getAll = (req: Request, res: Response) => {
		this.refugioService
			.geAll()
			.then(refugios => res.json(refugios))
			.catch(error => this.handleError(error, res));
	};

	create = (req: Request, res: Response) => {
		const { body } = req;
		body.image = req.file;

		this.refugioService
			.create(body)
			.then(refugio => res.status(201).json(refugio))
			.catch(error => this.handleError(error, res));
	};

	getById = (req: Request, res: Response) => {
		const { id } = req.params;

		this.refugioService
			.getById(id)
			.then(refugio => res.json(refugio))
			.catch(error => this.handleError(error, res));
	};

	update = (req: Request, res: Response) => {
		const { id } = req.params;
		const { body } = req;
		body.image = req.file;

		this.refugioService
			.update(id, body)
			.then(refugio => res.status(202).json(refugio))
			.catch(error => this.handleError(error, res));
	};

	delete = (req: Request, res: Response) => {
		const { id } = req.params;

		this.refugioService
			.delete(id)
			.then(() => res.status(202).json({ message: 'Refugio eliminado' }))
			.catch(error => this.handleError(error, res));
	};
}
