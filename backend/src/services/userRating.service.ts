import {
	UserRatingRequest,
	UserRatingModel,
	UpdateUserRatingRequest
} from '../models/UserRating.model';
import { RefugioModel } from '../models/refugio.model';
import { CustomError } from '../utils/custom.error';
import { User, UserModel } from '../models/user.model';
import { Request } from 'express';
import { ObjectId } from 'mongoose';

export class UserRatingService {
	constructor() {}

	async geAll() {
		const [total, ratings] = await Promise.all([
			UserRatingModel.countDocuments(),
			UserRatingModel.find()
		]);

		return { total, ratings };
	}

	async create(data: UserRatingRequest) {
		if (data.refugio) {
			const refugioExists = await RefugioModel.findById(data.refugio);

			if (!refugioExists) {
				throw CustomError.notFound('El refugio no existe');
			}
		}

		if (data.user) {
			const userExists = await UserModel.findById(data.user.id);

			if (!userExists) {
				throw CustomError.notFound('El usuario no existe');
			}

			data.user = data.user.id;
		}

		const newRating = new UserRatingModel(data);

		await newRating.save();

		return newRating;
	}

	async getById(id: string) {
		const ratingExists = await UserRatingModel.findById(id);

		if (!ratingExists) {
			throw CustomError.notFound('El Rating no existe');
		}

		return ratingExists;
	}

	async update(id: string, data: UpdateUserRatingRequest) {
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

		await UserRatingModel.updateOne({ id: ratingExists.id }, data);

		const updatedRating = await this.getById(ratingExists.id);

		return updatedRating;
	}

	async delete(id: string) {
		const ratingExists = await this.getById(id);

		if (String(ratingExists.user) !== id) {
			throw CustomError.badRequest(
				'No tienes permiso para eliminar esta Calificacion'
			);
		}

		await UserRatingModel.deleteOne({ id: ratingExists.id });
	}

	async getAverageByRefugio(refugioId: string) {
		const [total, ratings] = await Promise.all([
			UserRatingModel.countDocuments(),
			UserRatingModel.find({ id: refugioId })
		]);

		const rates: number[] = ratings.map(rating => rating.rate);
		const sum: number = rates.reduce((acc, element) => acc + element, 0);
		const averageRate = sum / total;

		return { averageRate };
	}

	async getAllAverage() {
		const [total, ratings] = await Promise.all([
			UserRatingModel.countDocuments(),
			UserRatingModel.find()
		]);

		const rates: number[] = ratings.map(rating => rating.rate);
		const sum: number = rates.reduce((acc, element) => acc + element, 0);
		const averageRate = sum / total;

		return { averageRate };
	}
}
