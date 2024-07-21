import { ObjectId } from 'mongoose';
import {
	PostModel,
	PostRequest,
	UpdatePostRequest
} from '../models/post.model';
import { RefugioModel } from '../models/refugio.model';
import { CustomError } from '../utils/custom.error';
import { handleUpload } from '../utils/imageUpload';

export class PostService {
	constructor() {}

	async geAll() {
		const [total, posts] = await Promise.all([
			PostModel.countDocuments(),
			PostModel.find()
		]);

		return { total, posts };
	}

	async create(data: PostRequest) {
		const refugioExists = await RefugioModel.findById(data.refugio);

		if (!refugioExists) {
			throw CustomError.notFound('El refugio no existe');
		}

		const imageUrl = await handleUpload(data.image);

		const tempPost = { ...data, image: imageUrl };

		const newPost = new PostModel(tempPost);

		await newPost.save();

		return newPost;
	}

	async getById(id: string) {
		const postExists = await RefugioModel.findById(id);

		if (!postExists) {
			throw CustomError.notFound('La publicación no existe');
		}

		return postExists;
	}

	async update(id: string, data: UpdatePostRequest) {
		const postExists = await this.getById(id);

		if (data.image) {
			const imageUrl = await handleUpload(data.image);

			const tempPost = { ...data, image: imageUrl };

			await PostModel.updateOne({ id }, tempPost);
		} else {
			await PostModel.updateOne({ id }, data);
		}

		const updatedPost = await this.getById(postExists.id);

		return updatedPost;
	}

	async delete(id: string) {
		const postExists = await this.getById(id);

		await PostModel.deleteOne({ id: postExists.id });
	}
}
