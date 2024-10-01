<!-- base.leaf -->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>#(title)</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/flowbite/1.6.1/flowbite.min.css" rel="stylesheet">
</head>
<body>
    <div class="flex">
        <!-- Sidebar -->
        <aside class="w-64 bg-gray-900 text-white">
            <div class="p-6">
                <h1 class="text-3xl font-semibold text-white mb-6">AppName</h1>
                <nav>
                    <ul>
                        <li><a href="/dashboard" class="block p-3 hover:bg-gray-700">Dashboard</a></li>
                        <li><a href="/users" class="block p-3 hover:bg-gray-700">Usuarios</a></li>
                        <li><a href="/patients" class="block p-3 hover:bg-gray-700">Pacientes</a></li>
                        <li><a href="/trips" class="block p-3 hover:bg-gray-700">Viajes</a></li>
                    </ul>
                </nav>
            </div>
        </aside>

        <!-- Main content -->
        <div class="flex-1 p-6">
            <!-- Header -->
            <header class="flex justify-between items-center mb-6">
                <h1 class="text-2xl font-bold">#(title)</h1>
                <a href="/logout" class="bg-red-500 hover:bg-red-600 text-white p-2 rounded">Logout</a>
            </header>

            <!-- Body content -->
            #import("content")
        </div>
    </div>
</body>
</html>
