import { ObjectId } from 'mongoose';
import {
	RatingModel,
	RatingRequest,
	UpdateRatingRequest
} from '../models/rating.model';
import { RefugioModel } from '../models/refugio.model';
import { CustomError } from '../utils/custom.error';
import { UserModel } from '../models/user.model';

export class RatingService {
	constructor() {}

	async geAll() {
		const [total, ratings] = await Promise.all([
			RatingModel.countDocuments(),
			RatingModel.find()
		]);

		return { total, ratings };
	}

	async create(data: RatingRequest) {
		if (data.refugio) {
			const refugioExists = await RefugioModel.findById(data.refugio);

			if (!refugioExists) {
				throw CustomError.notFound('El refugio no existe');
			}
		}

		if (data.user) {
			const userExists = await UserModel.findById(data.user);

			if (!userExists) {
				throw CustomError.notFound('El usuario no existe');
			}
		}

		const newRating = new RatingModel(data);

		await newRating.save();

		return newRating;
	}

	async getById(id: string) {
		const ratingExists = await RatingModel.findById(id);

		if (!ratingExists) {
			throw CustomError.notFound('El Rating no existe');
		}

		return ratingExists;
	}

	async update(id: string, data: UpdateRatingRequest) {
		const ratingExists = await this.getById(id);

		if (data.refugio) {
			const refugioExists = await RefugioModel.findById(data.refugio);

			if (!refugioExists) {
				throw CustomError.notFound('El refugio no existe');
			}
		}

		if (data.user) {
			const userExists = await UserModel.findById(data.user);

			if (!userExists) {
				throw CustomError.notFound('El usuario no existe');
			}
		}

		await RatingModel.updateOne({ id: ratingExists.id }, data);

		const updatedRating = await this.getById(ratingExists.id);

		return updatedRating;
	}

	async delete(id: string) {
		const ratingExists = await this.getById(id);

		await RatingModel.deleteOne({ id: ratingExists.id });
	}
}
