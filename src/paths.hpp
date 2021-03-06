#ifndef RMP_PATHS_HPP
#define RMP_PATHS_HPP

#include <string>

#include "puzzles.hpp"

namespace paths {

#ifdef RESIM
const std::string PUZZLE_DATA = ".";
#else
const std::string PUZZLE_DATA = "/opt/etc/puzzles";
#endif

inline std::string game_basename(const game *g)
{
    std::string ret;
    for (const char *c = g->name; *c != '\0'; c++)
        if (!isspace(*c))
            ret.push_back(tolower(*c));
    return ret;
}

inline std::string game_colors(const game *g)
{
    return PUZZLE_DATA + "/config/" + game_basename(g) + "_colors.conf";
}

inline std::string game_help(const game *g)
{
    return PUZZLE_DATA + "/help/" + game_basename(g) + ".txt";
}

inline std::string game_save(const game *g)
{
    return PUZZLE_DATA + "/save/" + game_basename(g) + ".sav";
}

inline std::string game_icon(const game *g)
{
    return PUZZLE_DATA + "/icons/" + game_basename(g) + ".png";
}

} // namespace

#endif // RMP_PATHS_HPP
