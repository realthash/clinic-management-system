import { prisma } from "../config/db.js";
import bcrypt from 'bcrypt'

//TODO: set cookies and jwt token
const registerUser = async (req, res) => {
    const { name, email, password, nic, phone } = req.body;

    console.log(password)
    const userExist = await prisma.patient.findUnique({ where: { email: email } });
    if (userExist) {
        return res.status(400).json({ message: "User exist with the email" });
    }

    //hashing password
    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(password, salt)

    //Post user data after validation
    const user = await prisma.patient.create({
        data: {
            name,
            email,
            password: hashedPassword,
            nic,
            phone
        }
    })

    res.status(201).json({
        status: "success", data: {
            name: user.name,
            email: user.email,
            nic: user.nic,
            phone: user.nic,
        }
    })
}

//TODO: user login logic with jwt token and cookies
const login = async (req, res) => {
    const { nic, password } = req.body;

    const isEmail = await prisma.patient.findUnique({ where: { nic: nic } });

    if (!isEmail) {
        return res.status(400).json({ status: false, message: "The entered credentials not valid" })
    }

    const matchedPassword = await bcrypt.compare(password, isEmail.hashedPassword);

    if (!matchedPassword) {
        return res.status(400).json({ status: false, message: "password is invalid" })
    }

    res.status(200).json({ success: true, message: "You are logged in" })
}

export { registerUser, login };