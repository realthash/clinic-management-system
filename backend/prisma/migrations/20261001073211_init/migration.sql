/*
  Warnings:

  - A unique constraint covering the columns `[nic]` on the table `patient` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "patient_nic_key" ON "patient"("nic");
