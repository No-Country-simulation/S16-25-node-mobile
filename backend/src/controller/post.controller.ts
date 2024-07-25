import { Request, Response } from 'express';
import { PostService } from '../services/post.service';
import { CustomError } from '../utils/custom.error';

export class PostController {
	constructor(private readonly postService: PostService) {}

	private handleError = (error: unknown, res: Response) => {
		if (error instanceof CustomError) {
			return res.status(error.statusCode).json({ message: error.message });
		} else {
			console.log(`${error}`);
			return res.status(500).json({ error: 'Internal server error' });
		}
	};

	getAll = (req: Request, res: Response) => {
		this.postService
			.geAll()
			.then(posts => res.json(posts))
			.catch(error => this.handleError(error, res));
	};

	create = (req: Request, res: Response) => {
		const { body } = req;
		body.image = req.file;

		this.postService
			.create(body)
			.then(post => res.status(201).json(post))
			.catch(error => this.handleError(error, res));
	};

	getById = (req: Request, res: Response) => {
		const { id } = req.params;

		this.postService
			.getById(id)
			.then(post => res.json(post))
			.catch(error => this.handleError(error, res));
	};

	update = (req: Request, res: Response) => {
		const { id } = req.params;
		const { body } = req;
		body.image = req.file;

		this.postService
			.update(id, body)
			.then(post => res.status(202).json(post))
			.catch(error => this.handleError(error, res));
	};

	delete = (req: Request, res: Response) => {
		const { id } = req.params;

		this.postService
			.delete(id)
			.then(() => res.status(202).json({ message: 'Publicacion eliminada' }))
			.catch(error => this.handleError(error, res));
	};
}
