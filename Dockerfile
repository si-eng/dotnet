# Use the official .NET SDK image as the base image
FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build

# Set the working directory in the container
WORKDIR /app

# Copy the project files to the container
COPY *.csproj .
COPY . .

# Build the application
RUN dotnet publish -c Release -o out

# Use a smaller runtime image as the final image
FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS runtime

# Set the working directory in the container
WORKDIR /app

# Copy the published application from the build image
COPY --from=build /app/out .

# Expose the port your application will listen on (adjust as needed)
EXPOSE 80

# Define the entry point for the application
ENTRYPOINT ["dotnet", "YourApp.dll"]
