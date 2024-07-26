import {
	RefugioRatingModel,
	RefugioRatingRequest,
	UpdateRefugioRatingRequest
} from '../models/RefugioRating.model';
import { RefugioModel } from '../models/refugio.model';
import { CustomError } from '../utils/custom.error';
import { UserModel } from '../models/user.model';

export class RefugioRatingService {
	constructor() {}

	async geAll() {
		const [total, ratings] = await Promise.all([
			RefugioRatingModel.countDocuments(),
			RefugioRatingModel.find()
		]);

		return { total, ratings };
	}

	async create(data: RefugioRatingRequest) {
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

		const newRating = new RefugioRatingModel(data);

		await newRating.save();

		return newRating;
	}

	async getById(id: string) {
		const ratingExists = await RefugioRatingModel.findById(id);

		if (!ratingExists) {
			throw CustomError.notFound('El Rating no existe');
		}

		return ratingExists;
	}

	async update(id: string, data: UpdateRefugioRatingRequest) {
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

		await RefugioRatingModel.updateOne({ id: ratingExists.id }, data);

		const updatedRating = await this.getById(ratingExists.id);

		return updatedRating;
	}

	async delete(id: string) {
		const ratingExists = await this.getById(id);

		await RefugioRatingModel.deleteOne({ id: ratingExists.id });
	}

	async getAverageByUser(userId: string) {
		const [total, ratings] = await Promise.all([
			RefugioRatingModel.countDocuments(),
			RefugioRatingModel.find({ user: userId })
		]);

		const rates: number[] = ratings.map(rating => rating.rate);
		const sum: number = rates.reduce((acc, element) => acc + element, 0);
		const averageRate = sum / total;

		return { averageRate };
	}

	async getAllAverage() {
		const [total, ratings] = await Promise.all([
			RefugioRatingModel.countDocuments(),
			RefugioRatingModel.find()
		]);

		const rates: number[] = ratings.map(rating => rating.rate);
		const sum: number = rates.reduce((acc, element) => acc + element, 0);
		const averageRate = sum / total;

		return { averageRate };
	}
}
