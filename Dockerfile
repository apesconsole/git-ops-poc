# Use an official Maven image as a build stage
FROM maven:3.8.4-openjdk-17-slim AS build

# Set the working directory
WORKDIR /.

# Copy your pom.xml and the source code into the container
COPY pom.xml . 
COPY src ./src

# Run the Maven build (this will compile and package your application)
RUN mvn clean install -DskipTests

# Create a new image for runtime (to reduce the image size)
FROM openjdk:17-jdk-slim

# Set working directory
WORKDIR /.

# Step 9: Copy the jar file built from the previous step
COPY --from=build /target/git-ops-poc.jar git-ops-poc.jar

# Step 10: Expose the port your application will run on
EXPOSE 8080

# Step 11: Set the entrypoint to run the jar file when the container starts
ENTRYPOINT ["java", "-jar", "git-ops-poc.jar"]
