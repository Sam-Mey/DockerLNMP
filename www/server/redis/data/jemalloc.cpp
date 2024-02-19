#include <iostream>
#include <fstream>
#include <deque>
#include <vector>
#include <thread>
#include <cstdlib>
#include <ctime>
#include <memory>

void fun()
{
    std::string line;
    size_t allocated = 0;
    size_t allocations = 0;
    std::deque<std::unique_ptr<char[]>> all;

    size_t n = 1024 * 1024 * 1024;
    std::srand(static_cast<unsigned int>(std::time(nullptr)));
    for (size_t i = 0; i < n; ++i)
    {
        if (allocations % 500000 == 0)
        {
            std::ifstream ifs("/proc/self/maps", std::ios_base::in);
            if (!ifs.is_open())
            {
                std::cerr << "unable to open mappings file" << std::endl;
                std::abort();
            }
            size_t mappings = std::count(std::istreambuf_iterator<char>(ifs), std::istreambuf_iterator<char>(), '\n');
            std::cout << "- i: " << i << ", allocations: " << allocations << ", mappings: " << mappings << ", allocated: " << allocated << "\n";
        }

        size_t s = std::rand() % (4096 * 128 / 8);
        if (s > 0)
        {
            auto p = std::make_unique<char[]>(s);
            ++allocations;
            allocated += s;
            all.push_back(std::move(p));
        }

        while (!all.empty() && allocated > 1024 * 1024 * 128)
        {
            all.pop_front();
            allocated -= s;
        }
    }
}

int main()
{
    std::vector<std::thread> threads;

    size_t n = 8;
    for (size_t i = 0; i < n; ++i)
    {
        threads.emplace_back(fun);
    }

    for (auto &it : threads)
    {
        it.join();
    }

    return 0;
}
