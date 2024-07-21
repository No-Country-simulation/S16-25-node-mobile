import { Router } from 'express';
import { PostService } from '../services/post.service';
import { PostController } from '../controller/post.controller';

export class PostRouter {
	static get routes(): Router {
		const router = Router();
		const postService = new PostService();
		const controller = new PostController(postService);

		router.get('/', controller.getAll);
		router.post('/', controller.create);
		router.get('/:id', controller.getById);
		router.put('/:id', controller.update);
		router.delete('/:id', controller.delete);

		return router;
	}
}
