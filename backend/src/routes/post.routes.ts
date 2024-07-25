import { Router } from 'express';
import { PostService } from '../services/post.service';
import { PostController } from '../controller/post.controller';
import upload from '../middlewares/handleFile';
import {
	bodyPostValidator,
	isMongoId,
	updateBodyPostValidator
} from '../middlewares/validators';

export class PostRouter {
	static get routes(): Router {
		const router = Router();
		const postService = new PostService();
		const controller = new PostController(postService);

		router.get('/', controller.getAll);
		router.post(
			'/',
			upload.single('image'),
			bodyPostValidator,
			controller.create
		);
		router.get('/:id', isMongoId, controller.getById);
		router.put('/:id', isMongoId, updateBodyPostValidator, controller.update);
		router.delete('/:id', isMongoId, controller.delete);

		return router;
	}
}
